From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.26.[1-3] + x61 tablet + x6ultrabase: no resume after	undocking
Date: Mon, 1 Sep 2008 19:34:36 +0100
Message-ID: <20080901183435.GA21829@srcf.ucam.org>
References: <200808301535.22419.sfking@fdwdc.com> <1220239048.24775.152.camel@rzhang-dt> <48BBC8FC.1020809@dbservice.com> <20080901112816.GA21970@khazad-dum.debian.net> <48BBDD2C.5020804@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52174 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbYIASep (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Sep 2008 14:34:45 -0400
Content-Disposition: inline
In-Reply-To: <48BBDD2C.5020804@dbservice.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>, Steven King <sfking@fdwdc.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Mon, Sep 01, 2008 at 02:16:44PM +0200, Tomas Carnecky wrote:

> I just tested suspend/resume with the CDROM drive removed (an empty
> bay). Suspend/resume now works just fine, regardless how I dock/undock
> the laptop.

Huh, interesting. We may be doing something wrong with the libata ACPI 
calls on resume in that case, and it would explain why I haven't seen 
this on my T-series (there's no bay in the dock :) ). Unfortunately all 
the other docks I have present the bay as USB mass storage, so I don't 
have anything to test here. I'll look into this tomorrow.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
