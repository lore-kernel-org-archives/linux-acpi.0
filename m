From: Chris Chiu <chiu@endlessm.com>
Subject: GemniLake laptops goes power off directly after performing suspend
Date: Tue, 5 Dec 2017 18:32:26 +0800
Message-ID: <CAB4CAwc3q+L9UyHL8W541HXOCUTG0tTx51TfZRyzn61qbyOeEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, lenb@kernel.org, Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-acpi@vger.kernel.org

Hi,
    I have 2 GemniLake laptops from ASUS, named X441MB and X507MA,
both go power off after I do "systemctl suspend" on top of kerne head
fd6d2e506ce6 (Merge tag 'docs-4.15-fixes' of git://git.lwn.net/linux).
I then wipe it out and install Windows RS3 instead, also goes to power
off after pressing media key for suspend(S3). Then I installed intel
graphic driver with the following version number, Windows has no
problem on suspend resume then.
"""
Release Version: Production Version
Package: 530967
Intel(R) Graphics Driver: 23.20.16.4849
Intel(R) Display Audio Driver: 10.00.00.1

"""

    One thing weird worths mention, I also tested the same thing on a
GemniLake Desktop with an older kernel (4.13), but there's no problem
with it. Any suggestion about how to find out which part could cause
this?

Chris
