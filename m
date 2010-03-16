From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v1] PNPACPI: ignore Consumer/Producer bit; all bridge resources are windows
Date: Tue, 16 Mar 2010 13:29:24 -0700
Message-ID: <201003161429.24933.bjorn.helgaas@hp.com>
References: <20100316202627.25544.28033.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:37421 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757559Ab0CPU3e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Mar 2010 16:29:34 -0400
In-Reply-To: <20100316202627.25544.28033.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Adam Belay <abelay@mit.edu>

On Tuesday 16 March 2010 02:26:27 pm Bjorn Helgaas wrote:
> 
> The Consumer/Producer bit in Address Space Descriptors is useless because
> BIOS vendors don't use it consistently.  We have to assume that all
> resources of bridges are really Producers, i.e., windows to the secondary
> bus.

This modifies some code that recently went into 2.6.34, but this
doesn't necessarily have to go in .34 because I don't think anybody
uses PNP window resources yet (they just show up in lspnp output and
/sys/bus/pnp/.../resources).

Bjorn
