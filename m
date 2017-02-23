From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 03/20] device property: of_property_read_string_array()
 returns number of strings
Date: Thu, 23 Feb 2017 17:42:07 -0600
Message-ID: <CAL_JsqK-jMEdtRPxVQxypPFxZL5SXe-7ACy5SDNzATVYtqApPA@mail.gmail.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com> <1487869276-25244-4-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751285AbdBWXn2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 18:43:28 -0500
In-Reply-To: <1487869276-25244-4-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>

On Thu, Feb 23, 2017 at 11:00 AM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> of_property_read_string_array() returns number of strings read if the
> target array of pointers is non-NULL. fwnode_property_read_string_array()
> is documented to return 0 in that case. Fix this.

It seems of_property_read_string_array is more capable. If the number
of strings is variable and I want use the fwnode API, then what do I
do? IMO, you should fix the fwnode API.

Rob
