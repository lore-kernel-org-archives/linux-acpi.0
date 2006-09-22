From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [Patch 0/3] ibm-acpi: Remove experimental flag from brightness and volume. Update documentation
Date: Fri, 22 Sep 2006 12:19:13 +0200
Message-ID: <20060922101913.276298370@datenfreihafen.org>
Reply-To: linux-thinkpad@linux-thinkpad.org
Return-path: <linux-thinkpad-admin@linux-thinkpad.org>
Sender: linux-thinkpad-admin@linux-thinkpad.org
Errors-To: linux-thinkpad-admin@linux-thinkpad.org
List-Help: <mailto:linux-thinkpad-request@linux-thinkpad.org?subject=help>
List-Post: <mailto:linux-thinkpad@linux-thinkpad.org>
List-Subscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=subscribe>
List-Unsubscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=unsubscribe>
List-Archive: <http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/>
To: borislav@users.sf.net
Cc: linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org, jeremy@goop.org, multinymous@gmail.com, hmh@hmh.eng.br
List-Id: linux-acpi@vger.kernel.org

Hello Borislav.

Since version 0.11 ecdump, brightness, volume and fan a available in
ibm-acpi, but only if you set experimental=1 on loading.

You released this version at 2005-03-17. So this is quit some time to
see if some of these features make problems.

I think it's ok to make ecdump and fan only available, if loaded with
experimental. As ecdump is only for debugging and explore new features
and fan stop can damage the hardware.

Both features were tested with various scripts and application for a long 
time without problems.

Second patch updates the documentation for the first patch.

Third one documents the new wan feature from Jeremy Fitzhardinge. Please review
this, as I don't have a device to test this.

Please apply.

regards
Stefan Schmidt
--

-- 
The linux-thinkpad mailing list home page is at:
http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
