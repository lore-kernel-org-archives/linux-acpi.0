From: "James H. Cloos Jr." <cloos-GRsvFm/Gh/pBDgjK7y7TUQ@public.gmane.org>
Subject: lcd backlight
Date: 12 Jul 2003 21:34:35 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m365m7jjkk.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

A bios setting causes a regular screen blank, but w/ acpi the lcd's
backlight is left on.  

The following function (based on 's radeontools) controls the
backlight perfectly:

void radeon_cmd_light(int param)
{
    unsigned long dac_cntl;

    dac_cntl = radeon_get(RADEON_LVDS_GEN_CNTL,"RADEON_LVDS_GEN_CNTL");
    if(param != 0) {
        dac_cntl |= RADEON_LVDS_ON;
    } else {
        dac_cntl &= ~ RADEON_LVDS_ON;
    }
    radeon_set(RADEON_LVDS_GEN_CNTL,"RADEON_LVDS_GEN_CNTL",dac_cntl);
}


What needs to be done, given this info on how to control the
backlight and the bios's dsdt, to convince the kernel to toggle
the backlight when the screen blanks?

-JimC



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
