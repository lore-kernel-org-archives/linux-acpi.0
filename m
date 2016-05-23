From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 2/2] acpi/einj: Make error paths more talkative
Date: Mon, 23 May 2016 16:01:00 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F3A0D3F79@ORSMSX114.amr.corp.intel.com>
References: <1463992084-10012-1-git-send-email-bp@alien8.de>
 <1463992084-10012-2-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54455 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876AbcEWQBE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 May 2016 12:01:04 -0400
In-Reply-To: <1463992084-10012-2-git-send-email-bp@alien8.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

> It is absolutely unfriendly when one sees this:
>
>   # modprobe einj
>   modprobe: ERROR: could not insert 'einj': No such device
>
> without anything in dmesg to tell one why the load failed.
>
> Beef up the error handling of the init function to be more user-friendly
> when the load fails.

Yes, yes. 1000 times yes.

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
