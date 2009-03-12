From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: help with fixing code for 2.6.29-rc7
Date: Thu, 12 Mar 2009 14:41:13 +0100
Message-ID: <200903121441.13936.rjw@sisk.pl>
References: <20090312115032.GB26205@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59028 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551AbZCLNlC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Mar 2009 09:41:02 -0400
In-Reply-To: <20090312115032.GB26205@gamma.logic.tuwien.ac.at>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-acpi@vger.kernel.org

On Thursday 12 March 2009, Norbert Preining wrote:
> Hi everyone,
> 
> I am trying to fix some code for 2.6.29-rc7:
> 
> ... acpi_handle handle ...
> 
>         struct acpi_namespace_node *node;
>         union acpi_operand_object *operand;
> 
> 1       node = (struct acpi_namespace_node *)handle;
> 2       operand = (union acpi_operand_object *)node->object;
> 
> 3       printk(KERN_WARNING DRV_PFX "method: name: %4.4s, args %X\n", node->name.ascii,
> 4              (u32) operand->method.param_count);
> 
> Compiling that I get errors
> 	error: dereferencing pointer to incomplete type
> in line 2,3,4.
> 
> Any suggestion how to fix that?

Seemingly, struct acpi_namespace_node is undefined.

Thanks,
Rafael
