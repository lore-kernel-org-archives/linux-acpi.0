From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Improve ACPI support for Apple hardware
Date: Tue, 11 Mar 2014 18:19:59 -0400
Message-ID: <1394576402-2910-1-git-send-email-matthew.garrett@nebula.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net
List-Id: linux-acpi@vger.kernel.org

Various Apple hardware features are disabled unless the OS claims to be
"Darwin" when queried by the firmware, most notably Thunderbolt hotplug
support. This patchset provides support for Darwin at the ACPI layer and
includes a couple of additional fixes to handle issues uncovered by the
change in firmware behaviour.

-- 
Matthew Garrett <matthew.garrett@nebula.com>
