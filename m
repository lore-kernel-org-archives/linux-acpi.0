From: Frans Pop <elendil@planet.nl>
Subject: Re: [2.6.25-rc1] System no longer powers off after shutdown
Date: Wed, 13 Feb 2008 20:28:20 +0100
Message-ID: <200802132028.20620.elendil@planet.nl>
References: <200802111623.38478.elendil@planet.nl> <200802131239.14305.elendil@planet.nl> <20080213165837.GA10129@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765611AbYBMT2j@vger.kernel.org>
In-Reply-To: <20080213165837.GA10129@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 13 February 2008, Greg KH wrote:
> > So, just on the off chance, I applied the patch below and bingo, the
> > system powers off again. I doubt this will be the correct solution, but
> > just in case it is, here's my signed off. A comment why the double put
> > is needed would probably be good though.
>
> There is a bug in the cpufreq kref logic that makes this "double put"
> necessary.  A real fix has already been posted to solve this issue, and
> I think it should be on it's way to Linus for -rc2 already.

OK, great.

Do you think that #6879 could be caused by a similar issue elsewhere in the 
tree? Can you give me some pointers on how I could find out (debugging to 
enable, instrumentation to add)?

> Please let me know if -rc2 comes out without this needed fix.

Will do.
