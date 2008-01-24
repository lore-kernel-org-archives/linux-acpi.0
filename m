From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 8/8] ACPI: DMI blacklist to reduce console warnings on OSI(Linux) systems.
Date: Wed, 23 Jan 2008 23:35:03 -0500
Message-ID: <200801232335.03453.lenb@kernel.org>
References: <1201141967-28134-1-git-send-email-lenb@kernel.org> <a1bd4e35e8d9df24db7d7addd74cbfcc87ec9fb3.1201141721.git.len.brown@intel.com> <200801240255.15294.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39551 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbYAXEfS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jan 2008 23:35:18 -0500
In-Reply-To: <200801240255.15294.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

On Wednesday 23 January 2008 21:55, Carlos Corbacho wrote:
> Why not just match on:
> 
> > +	.ident = "Acer",
> > +	.matches = {
> > +		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> > +		},
> > +	},
> 
> for all Acer laptops?

hmmm, because I assumed that dmi_check_system()
would do an exact string compare with "!strcmp()".

I'm surprised to discover it uses strstr() and matches
substrings instead.  Is there logic behind that?

Certainly it makes using a single entry to match
a vendor problematic, as a short vendor string
could potentially be a substring of a different (unknown) vendor...

-Len
