package com.example.demo.controller;

import com.example.demo.model.Bulletin;
import com.example.demo.service.BulletinService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/bulletin")
public class BulletinController {

    @Autowired
    private BulletinService bulletinService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @GetMapping("/list")
    public String listBulletins(@RequestParam(defaultValue = "1") int page, Model model) {
        long totalElements = bulletinService.countTotal();
        int totalPages = (int) Math.ceil((double) totalElements / 5);
        if(page > totalPages || page <=0 ) {
            throw new RuntimeException("wrong page no.");
        }

        List<Bulletin> bulletinList = bulletinService.findPaginated(page-1);
        model.addAttribute("bulletinList", bulletinList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "bulletin-list";
    }

    @GetMapping("/view")
    public String viewBulletin(@RequestParam("id") Integer id, Model model) {
        Bulletin bulletin = bulletinService.getBulletinById(id);
        if(bulletin == null) {
            throw new RuntimeException("not found");
        }
        model.addAttribute("bulletin", bulletin);
        model.addAttribute("mode", "view");
        return "bulletin-form";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        Bulletin bulletin = new Bulletin();
        bulletin.setPublisher("Administrator");
        model.addAttribute("bulletin", bulletin);
        model.addAttribute("mode", "edit");
        return "bulletin-form";
    }

    @GetMapping("/edit")
    public String showEditForm(@RequestParam("id") Integer id, Model model) {
        Bulletin bulletin = bulletinService.getBulletinById(id);
        model.addAttribute("bulletin", bulletin);
        model.addAttribute("mode", "edit");
        return "bulletin-form";
    }

    @PostMapping("/save")
    public String saveBulletin(@ModelAttribute("bulletin") Bulletin bulletin) {
        bulletinService.saveBulletin(bulletin);
        return "redirect:/bulletin/list";
    }

    @GetMapping("/delete")
    public String deleteBulletin(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        bulletinService.deleteBulletin(id);
        redirectAttributes.addFlashAttribute("message", "刪除成功！");
        return "redirect:/bulletin/list";
    }

    @GetMapping("/error")
    public String handleError() {
        return "error";
    }

}
