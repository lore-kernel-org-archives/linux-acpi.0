From: "Jonathan S. Shapiro" <shap@eros-os.com>
Subject: Bug (?) in ACPI info reporting
Date: Mon, 29 Sep 2008 13:08:31 -0400
Message-ID: <1222708111.3688.15.camel@shaptop.om-md.eros-os.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.eros-os.com ([74.86.120.2]:39588 "EHLO www.eros-os.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755985AbYI2SJj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Sep 2008 14:09:39 -0400
Received: from [192.168.1.46] (dsl092-046-242.blt1.dsl.speakeasy.net [66.92.46.242])
	(authenticated bits=0)
	by www.eros-os.com (8.14.2/8.14.2) with ESMTP id m8TH8V4K009372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2008 12:08:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I just stuck an HP ev089aa battery into a dv6000 family laptop. Here is
the content of /proc/acpi/battery/BAT0/info:

> present:                 yes
> design capacity:         6000 mAh
> last full capacity:      8384 mAh
> battery technology:      rechargeable
> design voltage:          14800 mV
> design capacity warning: 422 mAh
> design capacity low:     254 mAh
> capacity granularity 1:  10 mAh
> capacity granularity 2:  25 mAh
> model number:            Primary
> serial number:            
> battery type:            LION
> OEM info:                Hewlett-Packard


Note the reported design capacity is (a) lower than last full capacity,
which is clearly nonsensical, and (b) probably wrong, since manufacturer
spec on this battery is 8800mAh, per

 http://h20141.www2.hp.com/hpparts/Search_Results.asp?mscssid=AQNAGTTMERA38MKXNF2TN094B2SU9LUB&SearchInc=PartNumber

Anybody have an idea what is going on here? I haven't had a chance to
check the blacklist yet. I'm wondering if there may be a bug in the
multiple capacity granularity handling?


shap

