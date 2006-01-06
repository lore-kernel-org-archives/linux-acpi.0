From: "Seth, Rohit" <rohit.seth-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re. 2.6.15-mm1
Date: Thu, 5 Jan 2006 18:05:03 -0800
Message-ID: <01EF044AAEE12F4BAAD955CB7506494305977CC4@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Alexander Gran <alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org, reiserfs-dev-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, vs-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org, Dave Jones <davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Andrew Morton Thursday, January 05, 2006 4:22 PM

>> 8b 1d 10 00 00 0
>> 0 0f b6 c0 8d 48 04 8d 6c 24
>>  <3>[drm:drm_release] *ERROR* Device busy: 1 0
>> EDAC PCI- Detected Parity Error on 0000:00:1e.0
>
>OK.  I've been assuming that this is a DRM bug but I note that the AGP
tree
>has been dinking with agp_collect_device_status(), so perhaps I had the
>wrong David.
>
>> Additionally every second or so I got these console (and kernel of
>cource)
>> message:
>> EDAC PCI- Detected Parity Error on 0000:00:1e.0
>
>Alan, Rohit: do we expect that the EDAC fixes which you're cooking up
will
>address this?  I think not?
>

Nops.  That one patch does not address this issue.

-rohit
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
