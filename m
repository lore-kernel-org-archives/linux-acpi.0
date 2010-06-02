From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/2] ACPI: Store NVS state even when entering suspend
 to RAM
Date: Wed, 2 Jun 2010 00:32:25 -0300
Message-ID: <20100602033225.GA6511@khazad-dum.debian.net>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com>
 <1275078735-1866-2-git-send-email-mjg@redhat.com>
 <1275230404.14907.11.camel@maxim-laptop>
 <20100530145142.GA32078@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:34770 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755467Ab0FBDca (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jun 2010 23:32:30 -0400
Content-Disposition: inline
In-Reply-To: <20100530145142.GA32078@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Sun, 30 May 2010, Matthew Garrett wrote:
> On Sun, May 30, 2010 at 05:40:04PM +0300, Maxim Levitsky wrote:
> > Just one note, I am sure somebody will ask for s3_no_nvs option, just
> > like s4_no_nvs.
> 
> I'd be surprised. Better to add the option when we think it's needed.

Do _all_ Windows versions restore NVS over S3 suspend/resume?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
