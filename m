From: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: 2.6.17-rc5-mm3: "BUG: scheduling while atomic" flood when resuming from disk
Date: Tue, 13 Jun 2006 20:57:12 -0700
Message-ID: <986ed62e0606132057l3fe9ab9as2d512132cf203a5e@mail.gmail.com>
References: <986ed62e0606042223l2381d877g4bc798ec64804d43@mail.gmail.com>
	 <20060604225140.cf87519f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:27330 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751149AbWFND5N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Jun 2006 23:57:13 -0400
Received: by nz-out-0102.google.com with SMTP id s18so56081nze
        for <linux-acpi@vger.kernel.org>; Tue, 13 Jun 2006 20:57:12 -0700 (PDT)
In-Reply-To: <20060604225140.cf87519f.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, arjan@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

On 6/4/06, Andrew Morton <akpm@osdl.org> wrote:
> > [  487.203000] ACPI Exception (acpi_bus-0070): AE_NOT_FOUND, No
> > context for object [c174d620] [20060310]
>
> And this?

FWIW, I just found out that there was a new BIOS released for this
motherboard (MSI K8T Neo), and I just applied the update. The version
number jumped from 2.2 to 7.1, and judging from the appearance of the
BIOS screens, you would think that I had completely replaced the
motherboard. Anyway, so far, the new BIOS is now autodetecting the
memory timings correctly (previously it used to think my memory was
CAS3, not the CAS2 that it actually is), and I've just managed to
resume from S3 using the Ubuntu kernel without the computer
spontaneously rebooting and without experiencing video corruption or a
blank screen. (The S3 video problems used to happen under Windows XP
too, but I haven't yet tried that OS after the BIOS update.)

I probably won't be able to test an mm kernel again on this box for
several days (right now I'm dealing with both final exams for the
school quarter *and* hardware failures on other boxes). Once all that
is over with, I'll have to retest with the latest mm kernel at that
point.
-- 
-Barry K. Nathan <barryn@pobox.com>
