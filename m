From: "Saurabh Nanda" <saurabhnanda@gmail.com>
Subject: Laptop fan on Acer 4061NWLCi
Date: Mon, 3 Apr 2006 16:38:06 +0530
Message-ID: <794f042d0604030408k3073a44dg70255e3342f4a2db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.202]:44516 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751397AbWDCLIH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Apr 2006 07:08:07 -0400
Received: by xproxy.gmail.com with SMTP id t10so782115wxc
        for <linux-acpi@vger.kernel.org>; Mon, 03 Apr 2006 04:08:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have recently bought an Acer 4061NWLCi laptop and am having trouble
getting ACPI to work. I hope somoene will help me out :-)

I am running Ubuntu Linux -- Breezy Badger 5.10. With the default
Ubuntu kernel (2.6.12) ACPI did not work at all. I did not even get
the battery status in GNOME. Then I installed the latest kernel (
2.6.16.1) and ACPI started working - at least partially! I could check
my CPU temperature, AC adapter status, and battery status.

The only thing not working is the CPU fan. I tried reading through my
current(broken) DSDT and surprisingly there is no mention of a fan
anywhere! In the Thermal Zone configuration there is no mention of
_ACx (_AC0, _AC1, etc.) as well. I can post my DSDT to the list if it
would help.

Can anyone please help me in fixing this? Running my laptop without a
fan is pretty dangerous as the CPU temperatures crosses 65 degrees
celcius at times.

Can I declare a fan and an active cooling temperature point in the
DSDT, recompile it and hope that it would work? Has anyone else done
this kind of a thing before?

TIA
Nandz,
--
http://nandz.blogspot.com
http://foodieforlife.blogspot.com
