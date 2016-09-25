From: Srinivasan J <srinidpdk@gmail.com>
Subject: How does a guest OS differentiate between a Reboot/Shutdown ACPI event
Date: Sun, 25 Sep 2016 22:16:49 +0530
Message-ID: <CAEbeQ+qcxuyACveg5B0ML6PG52PwQpLDfFQoL4WFX3+WM1evaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36701 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938834AbcIYQqv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Sep 2016 12:46:51 -0400
Received: by mail-io0-f175.google.com with SMTP id m79so161969740ioo.3
        for <linux-acpi@vger.kernel.org>; Sun, 25 Sep 2016 09:46:50 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have Ubuntu 14.04.1 (ubuntu-14.04.1-server-amd64.iso) guest running
in a KVM host. The host is running Ubuntu 16.04. I'm trying to find
out how Ubuntu 14.04.1 differentiates between virsh shutdown and virsh
reboot commands issued in the host. I see that in both cases the ACPI
event seen at the guest are exactly same. The guest however correctly
shuts down on issuing "virsh shutdown" and correctly reboots on
issuing "virsh reboot".

syslog:Sep 25 12:33:51 ubuntu acpid: waiting for events: event logging is on
syslog:Sep 25 12:34:46 ubuntu acpid: received input layer event
"button/power PBTN 00000080 00000000"
syslog:Sep 25 12:34:46 ubuntu acpid: rule from /etc/acpi/events/powerbtn matched
syslog:Sep 25 12:34:46 ubuntu acpid: executing action "/etc/acpi/powerbtn.sh"
syslog:Sep 25 12:34:46 ubuntu acpid: action exited with status 0
syslog:Sep 25 12:34:46 ubuntu acpid: 1 total rule matched
syslog:Sep 25 12:34:46 ubuntu acpid: completed input layer event
"button/power PBTN 00000080 00000000"
syslog:Sep 25 12:34:46 ubuntu acpid: received netlink event
"button/power LNXPWRBN:00 00000080 00000001"
syslog:Sep 25 12:34:46 ubuntu acpid: rule from /etc/acpi/events/powerbtn matched
syslog:Sep 25 12:34:46 ubuntu acpid: executing action "/etc/acpi/powerbtn.sh"
syslog:Sep 25 12:34:46 ubuntu acpid: action exited with status 0
syslog:Sep 25 12:34:46 ubuntu acpid: 1 total rule matched
syslog:Sep 25 12:34:46 ubuntu acpid: completed netlink event
"button/power LNXPWRBN:00 00000080 00000001"
syslog:Sep 25 12:35:02 ubuntu acpid: starting up with netlink and the
input layer
syslog:Sep 25 12:35:02 ubuntu acpid: 1 rule loaded
syslog:Sep 25 12:35:02 ubuntu acpid: waiting for events: event logging is on
syslog:Sep 25 12:36:13 ubuntu acpid: received input layer event
"button/power PBTN 00000080 00000000"
syslog:Sep 25 12:36:13 ubuntu acpid: rule from /etc/acpi/events/powerbtn matched
syslog:Sep 25 12:36:13 ubuntu acpid: executing action "/etc/acpi/powerbtn.sh"
syslog:Sep 25 12:36:13 ubuntu acpid: action exited with status 0
syslog:Sep 25 12:36:13 ubuntu acpid: 1 total rule matched
syslog:Sep 25 12:36:13 ubuntu acpid: completed input layer event
"button/power PBTN 00000080 00000000"
syslog:Sep 25 12:36:13 ubuntu acpid: received netlink event
"button/power LNXPWRBN:00 00000080 00000001"
syslog:Sep 25 12:36:13 ubuntu acpid: rule from /etc/acpi/events/powerbtn matched
syslog:Sep 25 12:36:13 ubuntu acpid: executing action "/etc/acpi/powerbtn.sh"
syslog:Sep 25 12:36:13 ubuntu acpid: action exited with status 0
syslog:Sep 25 12:36:13 ubuntu acpid: 1 total rule matched
syslog:Sep 25 12:36:13 ubuntu acpid: completed netlink event
"button/power LNXPWRBN:00 00000080 00000001"
syslog:Sep 25 12:36:27 ubuntu acpid: starting up with netlink and the
input layer
syslog:Sep 25 12:36:27 ubuntu acpid: 1 rule loaded
syslog:Sep 25 12:36:27 ubuntu acpid: waiting for events: event logging is on


Guest details:

srinij@ubuntu:/$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 14.04.1 LTS
Release:        14.04
Codename:       trusty

Host details:

srinij@ubuntu-server-16x:~/Downloads$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 16.04 LTS
Release:        16.04
Codename:       xenial
srinij@ubuntu-server-16x:~/Downloads$ virsh version
Compiled against library: libvirt 1.3.1
Using library: libvirt 1.3.1
Using API: QEMU 1.3.1
Running hypervisor: QEMU 2.5.0

Regards,
Srini
