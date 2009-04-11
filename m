From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: High latency on /sys/class/thermal
Date: Sat, 11 Apr 2009 12:14:16 -0700
Message-ID: <20090411121416.91fe3c88.akpm@linux-foundation.org>
References: <20090411155612.5808570c@ua.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759183AbZDKTRd@vger.kernel.org>
In-Reply-To: <20090411155612.5808570c@ua.pt>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q? Tiago_Sim=F5es_Batista ?= <tiagosbatista@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

(cc linux-acpi)

On Sat, 11 Apr 2009 15:56:12 +0100 "Tiago Sim__es Batista" <tiagosbatista@gmail.com> wrote:

> Hi all
> 
> Yesterday, I recompiled my kernel (git + tuxonice)
> v2.6.30-rc1-1002-gac91f91, there were a couple of issues, the main one
> is ilustrated bellow.
> 
> I am not familiar with the kernel code, but if you give me some
> pointers, I will be glad to investigate this further
> 
> $time cat /sys/class/thermal/thermal_zone0/temp 
> 34000
> 
> real	0m6.613s
> user	0m0.000s
> sys	0m0.001s
> 

Is this a regression?  Was 2.6.29 OK?

Thanks.
