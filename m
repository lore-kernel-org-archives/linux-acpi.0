From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] acpi/einj: Make error paths more talkative
Date: Fri, 24 Jun 2016 15:36:51 +0200
Message-ID: <6106819.SzZRkndaQf@vostro.rjw.lan>
References: <1463992084-10012-1-git-send-email-bp@alien8.de> <1463992084-10012-2-git-send-email-bp@alien8.de> <3908561D78D1C84285E8C5FCA982C28F3A0D3F79@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59898 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751317AbcFXNca (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Jun 2016 09:32:30 -0400
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F3A0D3F79@ORSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Monday, May 23, 2016 04:01:00 PM Luck, Tony wrote:
> > It is absolutely unfriendly when one sees this:
> >
> >   # modprobe einj
> >   modprobe: ERROR: could not insert 'einj': No such device
> >
> > without anything in dmesg to tell one why the load failed.
> >
> > Beef up the error handling of the init function to be more user-friendly
> > when the load fails.
> 
> Yes, yes. 1000 times yes.
> 
> Acked-by: Tony Luck <tony.luck@intel.com>

Both [1-2/2] applied, thanks!

