From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: 2.6.14.3 suspend/resume with SMP (HT)
Date: Tue, 10 Jan 2006 15:54:03 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F10158042C@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Karl H. Beckers" <karl.h.beckers-hi6Y0CQ0nG0@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
>I have not used suspend successfully before on either the laptop in
>question or my home machine (as opposed to suspend2 ... but after
>installing ubuntu I was hoping the stuff provided would just work).
>
>You can find the requested files attached. The files *after-boot* were
>taken after the inital boot with ps and lsmod after stopping everything
>I could and unloading all modules I could.
>
>The files *after-reboot* were taking after the next reboot.
>
>@Pavel: I AM using 2.6.15-rc5 now. Have no idea if a driver is breaking
>things. Don't think it is at this point. When suspending in any other
>way but from single user mode with next to every process stopped and
>module unloaded suspend fails ... and that is prolly due to some driver
>but I was going to research that after resuming successfully once.
>
>Haven't been able to suspend/resume with nosmp kernels either, but
>haven't tried with 2.6.15-rc yet.
>Will try.
Does your problem look like below one?
http://bugzilla.kernel.org/show_bug.cgi?id=5757

IIRC, your CPU can't be booted after resume.

Thanks,
Shaohua
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
