From: Zwane Mwaikambo <zwane-tGiaVUSOoeej7qYf8Sx8sA@public.gmane.org>
Subject: Re: Ask devices to powerdown before S3 sleep
Date: Tue, 21 Jan 2003 02:56:33 -0500 (EST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.44.0301210241290.2653-100000@montezuma.mastecende.com>
References: <20030119214642.GA27885@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030119214642.GA27885-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 19 Jan 2003, Pavel Machek wrote:

> SUSPEND_RESUME phase is needed for turning off IO-APIC. [I believe
> SUSPEND_DISABLE should be so simple that errors just should not be
> there, and besides we would not know how to safely enable devices from
> such weird state, anyway]. Please apply,

panic() is a bit on the extreme side no? I know diddly about ACPI and 
the current code, but can't you check for _PS3 methods or _S3D mappings 
for your devices before hand to be certain that the system can even go 
down to S3 somewhat reliably?

	Zwane
-- 
function.linuxpower.ca
