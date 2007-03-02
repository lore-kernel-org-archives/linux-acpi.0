From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Conversion of ACPI fan+thermal to hwmon sysfs
Date: Fri, 02 Mar 2007 09:12:16 +0800
Message-ID: <1172797936.14827.33.camel@localhost.localdomain>
References: <20070224182024.GA23865@khazad-dum.debian.net>
	 <20070226172716.b2e956b7.khali@linux-fr.org>
	 <1172655111.11100.50.camel@localhost.localdomain>
	 <20070228143433.GB30168@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41684 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964793AbXCBBNT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Mar 2007 20:13:19 -0500
In-Reply-To: <20070228143433.GB30168@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jean Delvare <khali@linux-fr.org>
Cc: linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, lenb@kernel.org, konstantin.a.karasyov@intel.com

On Wed, 2007-02-28 at 11:34 -0300, Henrique de Moraes Holschuh wrote:
> (ibm-acpi-devel removed from cc, subject changed)
> 
> On Wed, 28 Feb 2007, Zhang Rui wrote:
> > I'm converting these two modules to sysfs. I think "thermal" has too
> > much ACPI specific information and is not that easy to have a generic
> > interface.
> 
> It is not easy.  In fact, it could be quite complicated.  But when combined
> with the fan objects, it should be possible.
> 
> hwmon's idea of thermal zones are chip-specific, so the way to get ACPI to
> work with that without much changes is to think of the entire ACPI model as
> a "single chip".  This probably means ACPI fan and thermal zones need to
> cooperate to be ported to the hwmon model.
> 

On Thu, 2007-03-01 at 08:06 +0100, Jean Delvare wrote: 
> Indeed, ACPI thermal zone may have more thermal trip points than the
> hwmon interface specifies. Two of the trip points can be mapped to
> temp1_max and temp1_crit, respectively. If we want to handle them all,
> then probably we have to implement Henrique's suggestion and really
> think in terms of thermal zones, i.e. the trip points would be mapped
> to temp1_auto_point[1-*]_temp and possibly associated with a fan speed
> output.
> 

Well, ACPI thermal zones are not only a logical collection of interfaces
to temperature sensors, trip points and thermal property information,
but also take charge of thermal controls, i.e. setting platform's
cooling mode policies.
I don't know if I missed something, but from Documentation/hwmon/sysfs-
interface, I can't find any interface that make it possible.
And, porting ACPI fan and thermal zones to the hwmon model? That is
really complicated.
Add Len and Konstantin to cc list and see if they have any ideas. :)
