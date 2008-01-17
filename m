From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 9/10] introduce intel_menlow platform specific driver
Date: Thu, 17 Jan 2008 14:51:18 -0500
Message-ID: <200801171451.18613.lenb@kernel.org>
References: <1200556278.2935.118.camel@acpi-sony.sh.intel.com> <20080117092030.a9dfe528.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58498 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757238AbYAQUnm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jan 2008 15:43:42 -0500
In-Reply-To: <20080117092030.a9dfe528.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sujith.thomas@intel.com


> > +static int
> > +memory_get_int_max_bandwidth(struct thermal_cooling_device *cdev,
> > +			     unsigned long *max_state)
> 
> Don't put 'static int' (return type etc.) on a line by itself.
> That format is not wanted in Linux.   (many places here)

if checkpatch.pl and Lindent are happey (which they are not, totally)
then I'm satisifed witht he Linux style of the code.

Randy, if you feel strongly about this this style nit,
then change Lindent to implement it -- nagging
developers about trivia is a waste of everybody's time.

thanks,
-Len
