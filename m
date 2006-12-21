From: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>
Subject: Re: Power States
Date: Thu, 21 Dec 2006 08:36:38 -0500
Message-ID: <458A8DE6.8050707@gmail.com>
References: <569c97d20612201033g69b7d345i657dc6f62f591854@mail.gmail.com>	 <45898257.5060004@linux.intel.com>	 <569c97d20612201051la543b85r11a789affe356e1@mail.gmail.com>	 <458988A4.7050801@linux.intel.com>	 <569c97d20612201109i7c8d3accl6ac2346ba023401b@mail.gmail.com>	 <45898B95.2020007@linux.intel.com>	 <569c97d20612201120q37e12982u7c006180604242b@mail.gmail.com> <1166693337.12505.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:51643 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422881AbWLUNhE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Dec 2006 08:37:04 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2386032wxd
        for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2006 05:36:42 -0800 (PST)
In-Reply-To: <1166693337.12505.7.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Balaji Rao <balajirrao@gmail.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

I am having a similar issue with my HP nc6400 laptop 1.83ghz

I get C1, C2 on AC adapter, and I get C1, C2, C3 on Battery, but I get 
no C0 (max mhz) and no C4 or C5. (Even though they are supported and 
used under windows when I boot into that "cra**y" OS.
My APM = yes
