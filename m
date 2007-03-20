From: Dave Jones <davej@redhat.com>
Subject: Re: Ambient Light Sensor?
Date: Tue, 20 Mar 2007 11:13:42 -0400
Message-ID: <20070320151342.GA8667@redhat.com>
References: <200703191341.41823.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:33387 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933679AbXCTPO5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:14:57 -0400
Content-Disposition: inline
In-Reply-To: <200703191341.41823.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Mon, Mar 19, 2007 at 01:41:41PM -0400, Len Brown wrote:
 > Has anybody seen ACPI-based ambient light sensor support on a commercial system?
 > 
 > You'd recognize it by a device with PNPid ACPI0008 exported via the AML device tree.
 > 
 > I've seen it on an Intel Capell Valley CRB, but I was wondering
 > if anybody is using it in the "real world" yet.
 > 
 > I've seen just the dmesg from a MacBook Pro on the web
 > suggesting that system exports ACPI0008:
 > http://www.uwsg.iu.edu/hypermail/linux/kernel/0703.0/1475.html

Right. Under OSX, it uses it to adjust the keyboard backlight.
(It may also do something fancy wrt gamma correction with the
 built-in webcam)

	Dave

-- 
http://www.codemonkey.org.uk
