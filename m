From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] hp-wmi: fix regressions caused by missing if statement
Date: Fri, 16 Jan 2009 18:57:20 -0600
Message-ID: <49712CF0.2050605@lwfinger.net>
References: <200901170013.55786.elendil@planet.nl> <200901170131.22541.elendil@planet.nl> <200901170155.02757.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933401AbZAQA5n@vger.kernel.org>
In-Reply-To: <200901170155.02757.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

Frans Pop wrote:
> From: Frans Pop <elendil@planet.nl>
> 
> hp-wmi: fix regressions caused by missing if statement
>     
> Error was introduced in commit fe8e4e039dc3.
>     
> Signed-off-by: Frans Pop <elendil@planet.nl>
> ---
>> On Saturday 17 January 2009, Frans Pop wrote:
>>> When I first booted .29-rc2 my HP 2510p notebook hung while loading
>>> hp-wmi, which I have listed in /etc/modules. Hard poweroff was
>>> needed.
> 
> And this obvious patch fixes the regression (tested).
> 
> Andrew: I've added you as the broken patch also went via you.
> 
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
