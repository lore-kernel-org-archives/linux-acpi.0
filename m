From: Jes Sorensen <jes@wildopensource.com>
Subject: Re: [DMESG] cpumask_t in action
Date: 10 Nov 2003 03:26:50 -0500
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <yq0brrky6gl.fsf@wildopensource.com>
References: <Pine.LNX.4.44.0311070907020.29453-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0311070907020.29453-100000@localhost.localdomain>
To: Sylvain Jeaugey <sylvain.jeaugey@bull.net>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

>>>>> "Sylvain" == Sylvain Jeaugey <sylvain.jeaugey@bull.net> writes:

Sylvain> These lines show you the numa topology of your machine (in
Sylvain> our case, we have 2 CPUS per domain, and a memory area).
Sylvain> This is quite a big piece of information about hardware. Even
Sylvain> if it is quite long, I think it should be part of the ACPI
Sylvain> information.

Hi Sylvian,

This information is much better exposed through sysfs (/sys) and Andi
Kleen's libnuma, which will also make it visible at runtime to
applications.

Cheers,
Jes
