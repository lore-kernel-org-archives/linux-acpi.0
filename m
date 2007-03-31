From: "Miles Lane" <miles.lane@gmail.com>
Subject: Fwd: [Bug 8286] New: HP dv1420us -- synaptics touchpad events do not wake the laptop from suspend state
Date: Fri, 30 Mar 2007 17:18:34 -0700
Message-ID: <a44ae5cd0703301718h62421922h53d0b42135ee00e6@mail.gmail.com>
References: <200703310016.l2V0GT5K015512@fire-2.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.177]:32321 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933161AbXCaASg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Mar 2007 20:18:36 -0400
Received: by ik-out-1112.google.com with SMTP id c21so568246ika
        for <linux-acpi@vger.kernel.org>; Fri, 30 Mar 2007 17:18:35 -0700 (PDT)
In-Reply-To: <200703310016.l2V0GT5K015512@fire-2.osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=8286

  Summary: HP dv1420us -- synaptics touchpad events do not wake the
                  laptop from suspend state
  Kernel Version: 2.6.21-rc5
  Status: NEW
  Severity: normal
  Owner: acpi_power-sleep-wake@kernel-bugs.osdl.org
  Submitter: miles.lane@gmail.com


Most recent kernel where this bug did *NOT* occur:

    This happens with all the ACPI-enabled kernels I have tried.

Distribution:

    Ubuntu 7.04 development packages
    FC7 development packages

Hardware Environment:

    HP dv1240us

Software Environment:
Problem Description:

    Synaptics touchpad events do not wake the laptop from suspend state

Steps to reproduce:

------- You are receiving this mail because: -------
You reported the bug, or are watching the reporter.
