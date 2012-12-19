From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Linux ACPI 5.0 _PSE(Power State for Enumeration) and _PRE (Power
 Resources for Enumeration) support
Date: Wed, 19 Dec 2012 11:17:16 +0100
Message-ID: <50D1942C.4020509@intel.com>
References: <CANh5a1zboBo+QxbAXA=PBc2-uS+R8-=UH1ZASWZqStycbG-1eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34623 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969Ab2LSKR3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Dec 2012 05:17:29 -0500
In-Reply-To: <CANh5a1zboBo+QxbAXA=PBc2-uS+R8-=UH1ZASWZqStycbG-1eQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Jeff.Wu" <chping@gmail.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Hi,

On 12/19/2012 8:55 AM, Jeff.Wu wrote:
> Hi  Rafael,Len,linux-acpi member,
>
> At the present, does Linux  kernel support ACPI 5.0 _PSE(Power State
> for Enumeration) and _PRE (Power Resources for Enumeration) ? If not,
> could you give us some suggestions for how to implement them ?

No, we don't support _PSE and _PRE yet, mostly because we didn't have a 
good use case before.  Can you please tell me what your use case is?

Rafael

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
z siedziba w Gdansku
ul. Slowackiego 173
80-298 Gdansk

Sad Rejonowy Gdansk Polnoc w Gdansku, 
VII Wydzial Gospodarczy Krajowego Rejestru Sadowego, 
numer KRS 101882

NIP 957-07-52-316
Kapital zakladowy 200.000 zl

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

