From: emisca <emisca.ml@gmail.com>
Subject: i810, mergedfb and lid switch and acpi video
Date: Thu, 11 Jan 2007 20:07:02 +0000
Message-ID: <414cba4e0701111207p6bb7e4cxdbb1995b7b30366b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces@lists.freedesktop.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: xorg@lists.freedesktop.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

I have an hp nx7400 notebook with intel 945gma. The lid switch
normally toggles (using acpi video module) internal display and
external display.
It works like a charm, unless using mergedfb. I have not tried with
dual screen or dual screen + xinerama because I was affected by the
bug fixed (probably, I've not tested it) by 1.7.4 version of the
driver.
Using mergedfb, if I press the lid switch or close the screen, the
display gets corrupted and I have to reinit the card switching to a
virtual console and returning back to X.

Is there a way to disable the switching behaviour of the acpi code? I
was able to disable completely the switch unloading the acpi video
module, but it's not the right way....

Bye
