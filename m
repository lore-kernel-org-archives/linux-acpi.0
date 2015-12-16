From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: question on possible functionality...
Date: Wed, 16 Dec 2015 04:18:32 +0100
Message-ID: <2082437.3D9tUlxHqv@vostro.rjw.lan>
References: <5670AE46.1000107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47791 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751445AbbLPCsX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Dec 2015 21:48:23 -0500
In-Reply-To: <5670AE46.1000107@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, David Box <david.e.box@linux.intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

On Tuesday, December 15, 2015 05:20:22 PM Al Stone wrote:
> Howdy.
> 
> I have run into a couple of cases now where is would like to do something
> like the following:
> 
>    $ iasl --acpi-version=5.1 apic.asl
> 
> to build a 5.1-compliant FADT, as compared to:
> 
>    $ iasl apic.asl
> 
> which always expects a very recent definition of the tables being defined.
> 
> Is anyone working on such a thing?  Or has it been contemplated in the past
> and discarded for some reason?

CCing the ACPICA maintainers.

Thanks,
Rafael

