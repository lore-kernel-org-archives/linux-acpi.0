From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v4 14/16] of: Add nop implementation of
 of_get_next_parent()
Date: Fri, 17 Mar 2017 14:10:46 +0200
Message-ID: <20170317121046.GL10701@valkosipuli.retiisi.org.uk>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
 <1488809970-25568-15-git-send-email-sakari.ailus@linux.intel.com>
 <3876288.h7t1S52nK5@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:42930 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751062AbdCQMKw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Mar 2017 08:10:52 -0400
Content-Disposition: inline
In-Reply-To: <3876288.h7t1S52nK5@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Hi Rafael,

On Mon, Mar 13, 2017 at 10:55:01PM +0100, Rafael J. Wysocki wrote:
> On Monday, March 06, 2017 04:19:28 PM Sakari Ailus wrote:
> > To avoid #ifdefs where the function is used.
> 
> A bit more explanation?
> 
> About where this happens (or will happen) to be used with CONFIG_OF unset?

v5.1 has:

of_get_next_parent() was only defined if CONFIG_OF was set. Using the
function thus requires #ifdef CONFIG_OF ... #endif in all cases. Avoid
having to use pre-processor macros around the function by providing a nop
implementation of of_get_next_parent().

> 
> Plus, that would require an ACK from Rob.

I checked with Rob (cc'd) that he's fine with the patch and that it goes
through your tree.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
