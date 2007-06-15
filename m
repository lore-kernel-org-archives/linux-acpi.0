From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Fri, 15 Jun 2007 13:35:46 +0100
Message-ID: <1181910946.4819.9.camel@work>
References: <878xb35sje.fsf@goat.bogus.local> <20070612153102.GD5986@ucw.cz>
	 <87fy4vmxva.fsf@goat.bogus.local>  <20070614195659.GE9442@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:29013 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbXFOMgr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jun 2007 08:36:47 -0400
Received: by wx-out-0506.google.com with SMTP id t15so852564wxc
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jun 2007 05:36:47 -0700 (PDT)
In-Reply-To: <20070614195659.GE9442@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2007-06-14 at 19:56 +0000, Pavel Machek wrote:
> 
> noapic/nolapic will not help with video issue. try s2ram from
> suspend.sf.net. 

Also there is (unashamed plug)
http://people.freedesktop.org/~hughsient/quirk/

Richard.

