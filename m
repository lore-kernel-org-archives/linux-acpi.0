From: Frittella Laurento <laurento.frittella@gmail.com>
Subject: How can I solve these DSL warnings?
Date: Wed, 09 May 2007 08:56:46 +0200
Message-ID: <464170AE.2000607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.182]:57240 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbXEIG5Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 May 2007 02:57:24 -0400
Received: by ik-out-1112.google.com with SMTP id b35so64939ika
        for <linux-acpi@vger.kernel.org>; Tue, 08 May 2007 23:57:23 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,
I'm trying to fix these warnings that appears during dsl compile:

  dsdt.dsl  2341:                 Method (_S0D, 0, NotSerialized)
  Warning  1097 -      Unknown reserved name ^  (_S0D)

Code (part of interest):
  Method (_S0D, 0, NotSerialized)
  {
      Store (SMI (0x85, 0x00), Local0)
      And (Local0, 0x01, Local0)
      If (LEqual (Local0, 0x00))
      {
        Return (0x03)
      }
      Else
      {
        Return (0x00)
      }
  }


The other kind of warning is:

  dsdt.dsl  3040:                         And (Local0, 0x0F)
  Warning  1104 -                                   ^ Result is not
used, operator has no effect

Code (part of interest):
  If (LLess (Local0, 0x80))
  {
    And (Local0, 0x0F)
    Store (0x01, Local1)
    ShiftLeft (Local1, Local0, Local1)
    Store (Local1, IRA)
  }


Another one:
  dsdt.dsl  3818:                     Return (Package (0x00) {})
  Remark   5070 -    Effective AML package length is zero ^

  Method (_DOD, 0, NotSerialized)
  {
     Return (Package (0x00) {})
  }

The last ;)
  dsdt.dsl  4044:                             Wait (EJTD, 0xA000)
  Warning  1103 -         Possible operator timeout is ignored ^

  Method (_EJ0, 1, NotSerialized)
  {
    Store (SMI (0x87, 0x00), MIS7)
    If (MIS7)
    {
      SMI (0xA6, 0x02)
      SMI (0x49, 0x01)
      Wait (EJTD, 0xA000)
      SMI (0x49, 0x00)
    }

    Return (0x00)
  }


I searched for them on the acpi website but I haven't find these warning
codes.

Regards,
Laurento
