From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: dmidecode output from Benq notebook
Date: Mon, 21 Jan 2008 02:51:34 -0500
Message-ID: <20080121075134.GC8105@mit.edu>
References: <web-7724225@backend13.aha.ru> <200801181856.30845.lenb@kernel.org> <web-56975710@backend13.aha.ru> <200801201408.40945.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:49926 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755621AbYAUHwA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 02:52:00 -0500
Content-Disposition: inline
In-Reply-To: <200801201408.40945.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Dmitry A. Marin" <corvax@corvax.ru>, linux-acpi@vger.kernel.org

On Sun, Jan 20, 2008 at 02:08:40PM -0500, Len Brown wrote:
> 
> OSI(Linux) has no effect on the AML of this machine,
> as OSYS is over-written.  So I'll just kill the warning
> on this box by adding it to the NOP DMI list.

The one thing I worry about is if you aren't including the BIOS
version in the DMI list, you could end up in a situation where one
version of the BIOS treats OSI(Linux) as a no-op, but a newer or an
older version of the BIOS actually does something with it....

BIOS writers can be sneaky that way.  :-)


      	      	     	  	   		  - Ted
