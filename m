From: GregR <grcore-9my5i9164tDQT0dZR+AlfA@public.gmane.org>
Subject: Re: Shutdown without poweroff (notebook)
Date: Tue, 17 Jan 2006 21:27:05 +0000 (UTC)
Message-ID: <loom.20060117T222431-215@post.gmane.org>
References: <200601171121.49406.oliver.eichler@dspsolutions.de> <20060117151411.GA20512@localhost.localdomain> <200601171658.25027.oliver.eichler@dspsolutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Oliver Eichler <oliver.eichler@...> writes:

> Yes, I know these. But no one seems to have problems with the power button. I 
> couldn't googel any other complain about the power button for this notebook. 
> I could find several power off complains for other devices, but their 
> solutions didn't work for me. That's why I ended up here as the last 
> resort :).

I had similar problems, I noticed that knoppix v4.0 powered of just fine. So I
copied the kernel .config, made a few changes pertaining to drivers that get
compiled it, and it works.  I really do not know which option(s) made the
difference though....

g 




-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
