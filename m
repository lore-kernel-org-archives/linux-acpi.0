From: Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH 3/4] nvdimm: Add IOCTL pass thru
Date: Wed, 11 Nov 2015 14:44:35 -0700
Message-ID: <20151111214435.GB95024@tevye.fc.hp.com>
References: <CAJN_NGaPbziX=OcyYpcn5TP76HwGQSTsUz-yOVGB2Sh8VxDQjA@mail.gmail.com>
 <20151109215904.GB33245@tevye.fc.hp.com>
 <CAJN_NGY0Zop4=_NrW8Y3md7Up9FRq9voQ2UYiTPgXCv9XP8u5A@mail.gmail.com>
Reply-To: Jerry.Hoemann@hpe.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2354.austin.hp.com ([15.217.128.53]:35641 "EHLO
	g2t2354.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbbKKVoj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2015 16:44:39 -0500
Content-Disposition: inline
In-Reply-To: <CAJN_NGY0Zop4=_NrW8Y3md7Up9FRq9voQ2UYiTPgXCv9XP8u5A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Krivenok <krivenok.dmitry@gmail.com>
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org

On Tue, Nov 10, 2015 at 06:05:15PM +0300, Dmitry Krivenok wrote:
> 
> >   list_for_each_entry(nvdimm_bus, &nvdimm_bus_list, list) {
> > - if (nvdimm_bus->id == id) {
> > + if (nvdimm_bus->id != id)
> 
> I noticed another minor issue. You have switched from "==" to "!="
> here, but you didn't add "break" after ioctl is handled for the found
> bus.
> 

I added the continue.

the code is going through a list and wants to only do action when it
matches on id.  but, we still want to go through entire list.

-- 

-----------------------------------------------------------------------------
Jerry Hoemann            Software Engineer      Hewlett-Packard Enterprise
-----------------------------------------------------------------------------
