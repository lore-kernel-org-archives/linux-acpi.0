From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 0/2] PNP: Avoid potential error code path problems
Date: Thu, 12 Mar 2015 02:20:07 +0100
Message-ID: <2163789.xYALhKGkH0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

These two patches fix potential issues related to failing device registration
in the PNP subsystem.

Comments welcome!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
