From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [patch 10/12] acpi: preserve correct battery state through
	suspend/resume cycles
Date: Tue, 10 Oct 2006 23:11:11 +0100
Message-ID: <1160518271.5494.21.camel@hughsie-laptop>
References: <200610102120.k9ALKfDU024293@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:3794 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030570AbWJJWLO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 18:11:14 -0400
Received: by ug-out-1314.google.com with SMTP id o38so7561ugd
        for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2006 15:11:13 -0700 (PDT)
In-Reply-To: <200610102120.k9ALKfDU024293@shell0.pdx.osdl.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, jikos@jikos.cz, pavel@ucw.cz, seife@suse.de

On Tue, 2006-10-10 at 14:20 -0700, akpm@osdl.org wrote:
> 
> The following patch adds ->resume method to the ACPI battery handler,
> which
> has the only aim - to check whether the battery state has changed
> during
> sleep, and if so, update the ACPI internal data structures, so that
> information published through /proc/acpi/battery/*/* is correct even
> after
> suspend/resume cycle, during which the battery was removed/inserted.

This would be great for gnome-power-manager and HAL. I've got open
bugzillas about this.

Richard.


