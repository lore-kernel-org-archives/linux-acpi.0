From: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 09:10:23 +0800
Message-ID: <200601090910.24397.luming.yu@intel.com>
References: <20060107172446.GA3092@srcf.ucam.org> <20060108134744.GA21538@srcf.ucam.org> <1136729632.2444.36.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1136729632.2444.36.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>  3. Use the new acpi kernel hotkeys stuff -- not that I really understand
>  the interface, nor how to use it correctly. Plus I'm not sure how much
>  of the vendor kernel modules can use this new interface, or if it's
>  suitable. It all seemed a bit fragile last time I looked.

Please take a look at 
http://bugzilla.kernel.org/show_bug.cgi?id=5749

There are some examples to use hotkey.c for specific laptops with dedicated
hotkey acpi device objects , and dedicated AML methods.
This patch: http://bugzilla.kernel.org/show_bug.cgi?id=5749#c3
can be used to replace sony_acpi.c

This patch: http://bugzilla.kernel.org/show_bug.cgi?id=5749#c4
can be used to support brightness control for panasonic laptop.

This patch: http://bugzilla.kernel.org/show_bug.cgi?id=5749#c5
can be used to support brighness contrl for ASUS laptop.

Please notes, I will update these patch against len's testing tree, and 
ask for inclusion.

-- 
Thanks,
Luming
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
