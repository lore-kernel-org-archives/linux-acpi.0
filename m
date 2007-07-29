From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: ACPI on Averatec 2370
Date: Sun, 29 Jul 2007 20:13:47 +0200
Message-ID: <46ACD8DB.2020108@googlemail.com>
References: <5ebbd9b50707291105w316f98e5h3fa17204c9119a2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933657AbXG2SSX@vger.kernel.org>
In-Reply-To: <5ebbd9b50707291105w316f98e5h3fa17204c9119a2f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Hale <frankhale@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

Frank Hale wrote:
[ added  linux-acpi to CC ]
> I have an Averatec 2370 laptop with the nVidia MCP51. With kernel
> 2.6.20 I had no issues with ACPI however with 2.6.21 and higher the
> kernel will hang on boot until I press the suspend button or the power
> button in which case the kernel wakes up and finishes the boot
> process. Including the following support only causes the issue:
> 
>  [*] ACPI Support
> 
> What I mean by that is every ACPI option has been deactivated and only
> ACPI support checked. The boot process with 2.6.21 and higher hangs at
> the point where the Scheduler is being registered.
> 
> io scheduler cfq registered (default)
> 
> If I allow it to sit there it never comes back to life and finishes
> booting. If I press the power or suspend button it will finish booting
> as expected.
> 
> I've scoured google for quite a while but cannot find any relevant
> information pertaining to this issue. For now I've disabled ACPI
> altogether.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
