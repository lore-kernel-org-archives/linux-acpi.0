From: Frank Seidel <fseidel@suse.de>
Subject: Re: [PATCH] ACPI: add missing KERN_* constants to printks
Date: Wed, 04 Feb 2009 16:48:58 +0100
Message-ID: <4989B8EA.5000105@suse.de>
References: <4989A784.3030604@suse.de> <200902041628.03675.elendil@planet.nl> <alpine.LRH.2.00.0902041642450.7690@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755005AbZBDPt2@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.00.0902041642450.7690@vixen.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, len.brown@intel.com, shaohuhua.li@intel.com, kristen.c.accardi@intel.com, frank@f-seidel.de
List-Id: linux-acpi@vger.kernel.org

Geert Uytterhoeven wrote:
> Actually they should, but the right prefix :-)
> 
> Quoting include/linux/kernel.h:
> ...

Ah, no i see. And i missed the line (from janitors todo) that
this should only be done for line beginnings (and now KERN_CONT
for core/arch..).
Thank you very much that pointer. Will keep it in mind for my
further cleanups of this topic.
Of course i will then also redo the above patch.

Thanks,
Frank
