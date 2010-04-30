From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: MacBookPro2,2 unable too boot with the latest HEAD
Date: Fri, 30 Apr 2010 21:49:13 +0100
Message-ID: <20100430204912.GA21240@srcf.ucam.org>
References: <i2vdd18b0c31004140812i6a0e9430u68ab49b24273fe9b@mail.gmail.com> <20100419142804.3cd53666.akpm@linux-foundation.org> <4BCCCCDF.4010605@gmail.com> <20100419145741.95688467.akpm@linux-foundation.org> <alpine.LFD.2.00.1004201011050.2402@sony> <4BD999C8.7090602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4BD999C8.7090602@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 29, 2010 at 07:38:00AM -0700, Justin P. Mattock wrote:

> This doesn't seem to be a big issue
> it's just one machine defaults to ac
> and then another machine defaults to battery
> (keep in mind both machines are iMac9,1's
> just different gpu's).

What do you mean, "Defaults to battery"? The iMac is a desktop machine, 
isn't it? There typically isn't an AC adapter present in the ACPI 
description.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
