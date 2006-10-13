From: "Kaburlasos, Nikos" <nikos.kaburlasos@intel.com>
Subject: USB suspend/resume in linux
Date: Thu, 12 Oct 2006 22:54:13 -0700
Message-ID: <0FB24CC078F78248B19595A43F00E01FD92D24@fmsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8335 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751009AbWJMFyP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Oct 2006 01:54:15 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Does anyone know whether the linux USB drivers support the suspend
feature on idle USB ports (i.e. the port has been idle for sometime and
so the driver transitions it in to a low-power 'suspend' state) while
the system is active and in S0 state? As far as I know, Windows don't
support that, I was wondering if linux does.

Please note, I have no background on linux or in OS programming (I am a
hardware guy), so please be gentle with the level of technical detail in
your response :-)

NK
