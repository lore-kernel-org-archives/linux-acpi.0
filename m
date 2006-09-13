From: "=?ISO-8859-1?Q?Rusl=E1n_Ledesma_Garza?="
	<ruslanledesmagarza@gmail.com>
Subject: Re: the role of the dstd
Date: Wed, 13 Sep 2006 12:06:51 -0500
Message-ID: <9d90148c0609131006o35571722laeeb05f37435ce87@mail.gmail.com>
References: <44EDFDD9.5030504@student.kuleuven.be>
	 <E1GGLZx-00037U-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:20133 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750793AbWIMRHZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Sep 2006 13:07:25 -0400
Received: by py-out-1112.google.com with SMTP id n25so3245559pyg
        for <linux-acpi@vger.kernel.org>; Wed, 13 Sep 2006 10:06:52 -0700 (PDT)
In-Reply-To: <E1GGLZx-00037U-00@skye.ra.phy.cam.ac.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, linux-acpi@vger.kernel.org

Is this option "act like windows" really available? Is it a boot parameter?

Thanks in advance.

On 8/24/06, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk> wrote:
> > For one, if the DSTD is part of the BIOS, how come windows does
> > work, while it must rely on the same data
>
> I'm not an ACPI expert but here is my understanding.  Hopefully it's
> close enough to reality that the experts need to make only minor
> corrections and can keep hacking.
>
> Often, or rather always, the manufacturer tests the DSDT only with
> Windows.  If Windows makes assumptions about how the DSDT code should
> be interpreted that are different from what Linux assumes, even if
> Linux's assumptions are compatible with the ACPI spec, then the DSDT
> might fail when run with Linux.
>
> For example, Windows serializes (runs in one thread) procedures
> automatically, even if a procedure is labelled NotSerialized.  But
> Linux ACPI, unless you pass a boot option to tell it to act like
> Windows, will not serialize those procedures, and each one can run in
> its own thread.
>
> Therefore, race conditions from a sloppy DSDT, which might be hidden
> in Windows, are often exposed in Linux.  And so S3 suspend might hang
> because of one of those races or locking problems.  My old Thinkpad
> 600X improved its S3 suspend behavior somewhat when booting with the
> "Act like Windows" option.
>
> ACPI development on Linux is often: "My laptop doesn't suspend in
> Linux" (for a modern laptop it's almost certain that it suspends in
> Windows) and then people finding what bug needs to be introduced into
> the Linux DSDT interpreter so that Linux can act just like Windows.
>
> -Sanjoy
>
> `Never underestimate the evil of which men of power are capable.'
>          --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
