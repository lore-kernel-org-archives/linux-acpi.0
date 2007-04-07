From: Andi Kleen <andi@firstfloor.org>
Subject: Re: CPU offline but power consumption increased?
Date: 08 Apr 2007 01:38:14 +0200
Message-ID: <p73odlzkb6h.fsf@bingen.suse.de>
References: <7e0bae390704062123i2dfaf030icd5a710677bc989a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965981AbXDGWjt@vger.kernel.org>
In-Reply-To: <7e0bae390704062123i2dfaf030icd5a710677bc989a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andika Triwidada <andika@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

"Andika Triwidada" <andika@gmail.com> writes:

[cc linux-acpi]
 
> Question: is that normal? I thought power consumption will be
> automatically reduced if one core offlined.

The current cpu offline essentially just runs a special idle loop.
The standard idle loop is even a bit more aggressive on some systems
because it knows about the deeper ACPI sleep modi.

There are also dependencies between cores because current CPUs
have shared power planes between cores.

I suppose in the future when a whole socket goes off line one could
implement special code to turn off the CPU further. But it likely
won't work on older hardware.

-Andi
