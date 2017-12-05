From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: GemniLake laptops goes power off directly after performing suspend
Date: Tue, 5 Dec 2017 16:01:56 +0100
Message-ID: <CAJZ5v0jS=E0mcm=R2xQSftSnzZXUbzL3RjjWafSYAB=Wd7=ECQ@mail.gmail.com>
References: <CAB4CAwc3q+L9UyHL8W541HXOCUTG0tTx51TfZRyzn61qbyOeEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAB4CAwc3q+L9UyHL8W541HXOCUTG0tTx51TfZRyzn61qbyOeEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Chiu <chiu@endlessm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 5, 2017 at 11:32 AM, Chris Chiu <chiu@endlessm.com> wrote:
> Hi,
>     I have 2 GemniLake laptops from ASUS, named X441MB and X507MA,
> both go power off after I do "systemctl suspend" on top of kerne head
> fd6d2e506ce6 (Merge tag 'docs-4.15-fixes' of git://git.lwn.net/linux).
> I then wipe it out and install Windows RS3 instead, also goes to power
> off after pressing media key for suspend(S3). Then I installed intel
> graphic driver with the following version number, Windows has no
> problem on suspend resume then.

There is a suspend-related fix missing in 4.15-rc at this point, so
please test 4.14.y or wait for the fix to be merged.

Thanks,
Rafael
