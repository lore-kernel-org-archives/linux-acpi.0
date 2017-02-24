From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 03/20] device property: of_property_read_string_array()
 returns number of strings
Date: Fri, 24 Feb 2017 10:15:45 +0200
Message-ID: <20170224081545.GU16975@valkosipuli.retiisi.org.uk>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
 <1487869276-25244-4-git-send-email-sakari.ailus@linux.intel.com>
 <CAL_JsqK-jMEdtRPxVQxypPFxZL5SXe-7ACy5SDNzATVYtqApPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:36562 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751001AbdBXIXC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Feb 2017 03:23:02 -0500
Content-Disposition: inline
In-Reply-To: <CAL_JsqK-jMEdtRPxVQxypPFxZL5SXe-7ACy5SDNzATVYtqApPA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>

Hi Rob,

On Thu, Feb 23, 2017 at 05:42:07PM -0600, Rob Herring wrote:
> On Thu, Feb 23, 2017 at 11:00 AM, Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> > of_property_read_string_array() returns number of strings read if the
> > target array of pointers is non-NULL. fwnode_property_read_string_array()
> > is documented to return 0 in that case. Fix this.
> 
> It seems of_property_read_string_array is more capable. If the number
> of strings is variable and I want use the fwnode API, then what do I
> do? IMO, you should fix the fwnode API.

It is not more capable but simply different.

The caller typically needs to allocate memory to hold a pointer array, which
means it needs to call the function with NULL output array argument anyway.
There is the special case where the maximum number of strings is known,
though. You could remove an additional call in this case.

However, why I do argue for this interface is safety: returning zero on
success is always a safe choice. Programmers often check for zero only
because it might be shorter to write or someone might thing it looks nicer:

int ret = fwnode_property_read_string_array(fwnode, "foo");
if (ret)
	goto err;

Additionally, returning zero is consistent within the pack: the OF (and
fwnode) integer array access functions return zero on success, i.e. not the
number of array elements read.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
