From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: sony vaio pcg-k45 hell
Date: Wed, 26 Oct 2005 10:29:00 +0800
Message-ID: <200510261029.01166.luming.yu@intel.com>
References: <3ACA40606221794F80A5670F0AF15F84041AC212@pdsmsx403> <64b848100510231807u36cd8056q521204eaa9099ebc@mail.gmail.com> <20051024102231.GA32705@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051024102231.GA32705-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> you need Stelian Pop's sony_acpi module for that (and a mechanism to adjust
> the brightness on ac adapter plug/unplug, powersaved does this on SUSE).
> It might also work with the generic_hotkey module, but i could not figure
> out how to do it (i remember posts on acpi-devel that claimed that all
> vendor specific acpi drivers are obsoleted by generic_hotkey, still have
> to find out how to control the brightness of my panasonic with it).
Some progress are made on generic_hotkey driver.  There is an example of
leverage generic_hotkey driver for sony laptop.
http://bugzilla.kernel.org/show_bug.cgi?id=4876#c4

>
> > (7) hotkeys for changing brightness etc do not work.
>
> SONY crap. These are no ACPI hotkeys, all the hotkeys on the vgn-fs115
> emitted a standard keycode. Unfortunately all emitted the same keycode.
>

Please post acpidump output for vgn-fs115, Let me check if there are any
ACPI hotkey support.

-- 
Thanks,
Luming


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
