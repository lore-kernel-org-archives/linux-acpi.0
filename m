From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: ACPI: EC: evaluating _Q10
Date: Tue, 02 Jan 2007 21:32:06 +0100
Message-ID: <459AC146.9020804@m3y3r.de>
References: <45992109.9050009@m3y3r.de> <200701021205.07817.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753691AbXABUdO@vger.kernel.org>
In-Reply-To: <200701021205.07817.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Len Brown schrieb:
> The bigger question is why you get "tons of these" --
> as EC  events are usually infrequent.
> Do you have a big number next to "acpi" in /proc/interrupts?
> If so, at what rate is it growing?
>
> thanks,
> -Len

maybe tons were a bit to overstated... After a fresh reboot, i count 110 
_q10 and one _q21messages now with 8 min. uptime and around 10300 acpi 
interrupts.
