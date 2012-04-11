From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: [PATCH V2 0/3] PNP: Allow PNP resources to be disabled (interface)
Date: Wed, 11 Apr 2012 22:45:58 +0200
Message-ID: <4F85ED86.8010002@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:33618 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1761194Ab2DKUqK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Apr 2012 16:46:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bhelgaas@google.com, lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hello everybody, 

this simple patch series continues the work begun in commit 
18fd470a48396c8795ba7256c5973e92ffa25cb3 where ACPI PNP resource templates 
with empty/disabled resources are handled.  

The aim of this patch series is to allow to set resources as "disabled" using 
the "/sys/bus/pnp/devices/*/resources" interface.  Such "disabled" resources 
are needed by some vintage IBM ThinkPads like the 600E where some devices need 
to have their IRQs disabled in order to support all the devices the 600E has. 

To better understand the motivation, let's look at an excerpt from the 600E's 
DSDT:

    Name (PLPT, ResourceTemplate ()
    {
        StartDependentFnNoPri ()
        {
            IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
            IRQNoFlags () {7}
        }
        /* Some entries deleted */
        StartDependentFnNoPri ()
        {
            IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
            IRQNoFlags () {}
        }
        EndDependentFn ()
    })

As one can see, the IRQ line for the second option is empty/disabled.  Also, 
both options share the same priority.  In order to be able to use the IRQ 7 for 
some other device, it is necessary to select the second option, which can be 
done with the patch series applied.

To this end, some preparatory work is done, simplifying the code, and fixing a
potential issue when explicitely assigning resources. 

Here's a brief description of these patches. 

[1/3] - Factor out common some code
[2/3] - Perform the actual setting
[3/3] - Handle IORESOURCE_BITS in resource allocation

The patches are applied against Linux 3.3.x. 

Comments are, as always, welcome.


Changes from previous versions:

V1 -> V2: Split [V1 2/3] into [V2 2/3] and [V2 3/3]
          Removed [V1 3/3], will be submitted separately
          Wrote more comments in response to the previous version
          Sent to a broader audience

V1:       Initial version (https://lkml.org/lkml/2012/3/20/358)


--- Witold
