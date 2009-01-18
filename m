From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: 2.6.29-rc2 regression: hibernation hang on eeepc-701 (method
	"platform" only)
Date: Sun, 18 Jan 2009 11:45:18 +0000
Message-ID: <9b2b86520901180345j434eacbdn7386958991ee50b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hibernation hangs just after writing the image.  With s2disk I can see
this from the console messages.  The same hang happens with kernel
swsusp ('echo disk | sudo tee /sys/power/state'), and I can see that
the image has been written from the HDD led.

In either case, I can still hard-power-off and resume from hibernation.

It doesn't hang if I use the shutdown method (either 'echo shutdown |
sudo tee /sys/power/disk' or  's2disk -P "shutdown method=shutdown"').

Let me know if you'd like more information.

Thanks
Alan
