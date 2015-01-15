From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
Date: Thu, 15 Jan 2015 18:19:42 +0100
Message-ID: <8006947.3odLx91sYj@wuerfel>
References: <548F9668.6080900@linaro.org> <CACxGe6t9Rbrr5166UDm8T7UVM_4k9jBFv=ozJB1zY=Kvi6F1LQ@mail.gmail.com> <54B5B7B9.6090101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51398 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbbAORUN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jan 2015 12:20:13 -0500
In-Reply-To: <54B5B7B9.6090101@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Al Stone <ahs3@redhat.com>, Grant Likely <grant.likely@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tuesday 13 January 2015 17:26:33 Al Stone wrote:
> On 01/13/2015 10:22 AM, Grant Likely wrote:
> > On Mon, Jan 12, 2015 at 7:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Monday 12 January 2015 12:00:31 Grant Likely wrote:
> >>> RAS is also something where every company already has something that
> >>> they are using on their x86 machines. Those interfaces are being
> >>> ported over to the ARM platforms and will be equivalent to what they
> >>> already do for x86. So, for example, an ARM server from DELL will use
> >>> mostly the same RAS interfaces as an x86 server from DELL.
> >>
> >> Right, I'm still curious about what those are, in case we have to
> >> add DT bindings for them as well.
> > 
> > Certainly.
> 
> In ACPI terms, the features used are called APEI (Advanced Platform
> Error Interface), and defined in Section 18 of the specification.  The
> tables describe what the possible error sources are, where details about
> the error are stored, and what to do when the errors occur.  A lot of
> the "RAS tools" out there that report and/or analyze error data rely on
> this information being reported in the form given by the spec.
> 
> I only put "RAS tools" in quotes because it is indeed a very loosely
> defined term -- I've had everything from webmin to SNMP to ganglia,
> nagios and Tivoli described to me as a RAS tool.  In all of those cases,
> however, the basic idea was to capture errors as they occur, and try to
> manage them properly.  That is, replace disks that seem to be heading
> down hill, or look for faults in RAM, or dropped packets on LANs --
> anything that could help me avoid a catastrophic failure by doing some
> preventive maintenance up front.
> 
> And indeed a BMC is often used for handling errors in servers, or to
> report errors out to something like nagios or ganglia.  It could
> also just be a log in a bit of NVRAM, too, with a little daemon that
> reports back somewhere.  But, this is why APEI is used: it tries to
> provide a well defined interface between those reporting the error
> (firmware, hardware, OS, ...) and those that need to act on the error
> (the BMC, the OS, or even other bits of firmware).
> 
> Does that help satisfy the curiosity a bit?

Yes, it's much clearer now, thanks!

	Arnd
