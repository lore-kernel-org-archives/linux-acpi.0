From: Thomas Renninger <trenn@suse.de>
Subject: Re: kernel panic
Date: Mon, 31 Oct 2011 13:24:04 +0100
Message-ID: <201110311324.05185.trenn@suse.de>
References: <4EA549C3.4080206@ntlworld.com> <CAErSpo4_epbHEAH3Ah=07NZFjqQedUcMXh+cxTSJ4Mp9KhvfPw@mail.gmail.com> <201110280413.51751.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35149 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932704Ab1JaLXp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 31 Oct 2011 07:23:45 -0400
In-Reply-To: <201110280413.51751.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: nick bray <nick.bray1@ntlworld.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Zhang Rui <rui.zhang@intel.com>

On Friday 28 October 2011 04:13:50 Thomas Renninger wrote:
...
> Ah, maybe an older acpidump got used and the _CST method of the
> object is in a not exported, dynamically loaded SSDT.
> This is very likely.
> 
> Please use a very recent acpidump:
> Hm, Len's ftp directory on kernel.org where latest acpidump was
> located is gone?
I've put a (hopefully) recent acpidump source here:
ftp.suse.com/pub/people/trenn/acpidump
Should get available in an hour or so.

I expect you see:
"Dynamic OEM Table Load"
message(s) in dmesg and the SSDT which includes the ACPI parts which are
causing this is loaded at runtime. Older acpidump versions were not able
to extract these, the one I put on my ftp account should be able to.

Can you run it and put the output somewhere (related Ubuntu bug?) and
provide a pointer to it, please.
Hm, you could create a bug here:
http://acpica.org/bugzilla
It looks like ACPI code in the _CST function is triggering an ACPICA
interpreter memory bug when it tries to evaluate the func (guessing...).

    Thomas
