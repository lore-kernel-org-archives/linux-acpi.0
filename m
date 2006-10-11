From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Wed, 11 Oct 2006 09:12:44 +0100
Message-ID: <20061011081244.GA6915@srcf.ucam.org>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <1160549944.3000.347.camel@laptopd505.fenrus.org> <20061011070412.GA6128@srcf.ucam.org> <200610111104.50563.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:26544 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1161024AbWJKIM5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Oct 2006 04:12:57 -0400
Content-Disposition: inline
In-Reply-To: <200610111104.50563.ismail@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ismail Donmez <ismail@pardus.org.tr>
Cc: Arjan van de Ven <arjan@infradead.org>, Yu Luming <luming.yu@gmail.com>, Matt Domsch <Matt_Domsch@dell.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net

On Wed, Oct 11, 2006 at 11:04:48AM +0300, Ismail Donmez wrote:

> device_id:    0x0410
> type:         UNKNOWN
> known by bios: no

This one's an LCD, according to the spec. The id spec was changed 
slightly in 3.0 of the acpi spec (in a backwards compatible way) - I'd 
guess that the acpi video driver just hasn't been updated.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
