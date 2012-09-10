From: Mr Dash Four <mr.dash.four@googlemail.com>
Subject: Re: ACPI conflicts
Date: Mon, 10 Sep 2012 02:17:40 +0100
Message-ID: <504D3FB4.2020100@googlemail.com>
References: <504D2D39.5090709@googlemail.com>	 <1347238787.1682.1045.camel@rui.sh.intel.com>	 <504D3CFC.2080805@googlemail.com> <1347239756.1682.1046.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33077 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029Ab2IJBRn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Sep 2012 21:17:43 -0400
Received: by wgbdr13 with SMTP id dr13so1448529wgb.1
        for <linux-acpi@vger.kernel.org>; Sun, 09 Sep 2012 18:17:42 -0700 (PDT)
In-Reply-To: <1347239756.1682.1046.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

> then how about clearing CONFIG_LPC_ICH?
Good catch! I also have CONFIG_LPC_SCH, should I clear that too?

