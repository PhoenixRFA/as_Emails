﻿using System.Web;
using System.Web.Optimization;

namespace as_Emails
{
    public class BundleConfig
    {
        // Дополнительные сведения об объединении см. на странице https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js",
                        "~/Scripts/jquery.fancybox.pack.js"
                        ));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Используйте версию Modernizr для разработчиков, чтобы учиться работать. Когда вы будете готовы перейти к работе,
            // готово к выпуску, используйте средство сборки по адресу https://modernizr.com, чтобы выбрать только необходимые тесты.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js",
                      "~/js/editable/bootstrap-editable.js",
                      "~/Scripts/jquery.bootstrap-growl.js"));

            bundles.Add(new ScriptBundle("~/bundles/AS").Include(
                        "~/js/AS/as.resources.js",
                        "~/js/AS/as.sys.js",
                        "~/js/AS/as.tools.js",
                        "~/js/AS/as.makeup.js",
                        "~/js/chosen/chosen.jquery.js",
                        //"~/js/pagination/pagination.min.js",
                        "~/js/AS/as.crud2.js",
                        "~/js/AS/as.emails.js"));


            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/bootstrap-editable.css",
                      "~/Content/fa/all.css",
                      "~/Content/site.css"));

            bundles.Add(new StyleBundle("~/Content/fancy").Include(
                      "~/js/fancy/source/jquery.fancybox.css"));

            bundles.Add(new StyleBundle("~/Content/AS").Include(
                      "~/Content/as.crud2.css",
                      "~/Content/chosen.min.css"));
        }
    }
}
