From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: [PATCH] acpid
Date: Sat, 24 Jul 2004 19:14:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1090692887.4739.2.camel@darkstar>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-AUWOXfwxwJedjV7baRG4"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-AUWOXfwxwJedjV7baRG4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi=20

Well, PATCHES speak better then me,

1 - sample.conf make power button works is very useful when a machine
hangs if power button send event we can shutdown machine without abrupt
power off

2 - acpid.init and acpid.spec updated with work of Redhat/Fedora guys.

3 - I don't know if you know but just in case, redhat modify your source
and eliminated all stuff about "Check that the kernel supports the
proper semantics, or die.". I don't know if it is because knows that kernel
are updated or if reads with other technique,  anyway it is working on
Fedora core 1.

thanks,
--=20
S=E9rgio M. B.

--=-AUWOXfwxwJedjV7baRG4
Content-Disposition: attachment; filename=acpid-RHbadkernerlcorrection.diff
Content-Type: text/x-patch; name=acpid-RHbadkernerlcorrection.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- acpid-1.0.3.orig/acpid.c	2004-02-12 20:03:33.000000000 +0000
+++ acpid-1.0.3/acpid.c	2004-05-30 06:27:02.000000000 +0100
@@ -61,6 +61,8 @@
 {
 	int event_fd;
 	int sock_fd;
+        int max_fd_num;
+        fd_set readfds, testfds;
 
 	/* learn who we really are */
 	progname = (const char *)strrchr(argv[0], '/');
@@ -78,39 +80,6 @@
 	}
 	fcntl(event_fd, F_SETFD, FD_CLOEXEC);
 
-/*
- * if there is data, and the kernel is NOT broken, this eats 1 byte.  We
- * can't have that.  This is ifdef'ed out on the assumption that old kernels
- * are out of popular use, by now.
- */
-#ifdef TEST_FOR_BAD_KERNELS
-	/*
-	 * Older kernels did not support read() properly or poll() at all
-	 * Check that the kernel supports the proper semantics, or die.
-	 *
-	 * Good kernels will respect O_NONBLOCK and return -1.  Bad kernels
-	 * will ignore O_NONBLOCK and return 0.  Really bad kernels will block
-	 * and overflow the buffer.  Can't deal with the really bad ones.
-	 */
-	{
-		int fl;
-		char buf;
-
-		fl = fcntl(event_fd, F_GETFL);
-		fcntl(event_fd, F_SETFL, fl | O_NONBLOCK);
-		if (read(event_fd, &buf, 1) == 0) {
-			fprintf(stderr, 
-				"%s: this kernel does not support proper "
-				"event file handling.\n"
-				"Please get the patch from "
-				"http://acpid.sourceforge.net\n", 
-				progname);
-			exit(EXIT_FAILURE);
-		}
-		fcntl(event_fd, F_SETFL, fl);
-	}
-#endif
-
 	/* open our socket */
 	if (!nosocket) {
 		sock_fd = ud_create_socket(socketfile);
@@ -166,77 +135,83 @@
 	/* read in our configuration */
 	acpid_read_conf(confdir);
 
+        /* setup the fds for select() */
+        max_fd_num = ((event_fd > sock_fd)?event_fd:sock_fd);
+        FD_ZERO(&readfds);
+        FD_SET(event_fd, &readfds);
+        FD_SET(sock_fd, &readfds);
+
 	/* main loop */
 	while (1) {
-		struct pollfd ar[2];
 		int r;
 		int fds = 0;
-		
-		/* poll for the socket and the event file */
-		ar[0].fd = event_fd; ar[0].events = POLLIN; fds++;
-		if (!nosocket) {
-			ar[1].fd = sock_fd; ar[1].events = POLLIN; fds++;
-		}
-		r = poll(ar, fds, -1);
-
-		if (r < 0 && errno == EINTR) {
-			continue;
-		} else if (r < 0) {
-			acpid_log("ERR: poll(): %s\n", strerror(errno));
-			continue;
-		}
-
-		/* was it an event? */
-		if (ar[0].revents) {
-			char *event;
-			
-			/* this shouldn't happen */
-			if (!ar[0].revents & POLLIN) {
-				acpid_log("odd, poll set flags 0x%x\n", 
-					ar[0].revents);
-				continue;
-			}
 
-			/* read and handle an event */
-			event = read_line(event_fd);
-			if (event) {
-				acpid_log("received event \"%s\"\n", event);
-				acpid_handle_event(event);
-				acpid_log("completed event \"%s\"\n", event);
-			} else {
-				static int nerrs;
-				if (++nerrs >= ACPI_MAX_ERRS) {
-					acpid_log("too many errors reading "
-						"events file - aborting\n");
-					break;
-				}
-			}
-		} 
-
-		/* was it a new connection? */
-		if (!nosocket && ar[1].revents) {
-			int cli_fd;
-			struct ucred creds;
-			char buf[32];
-
-			/* this shouldn't happen */
-			if (!ar[1].revents & POLLIN) {
-				acpid_log("odd, poll set flags 0x%x\n", 
-					ar[1].revents);
-				continue;
-			}
-
-			/* accept and add to our lists */
-			cli_fd = ud_accept(sock_fd, &creds);
-			if (cli_fd < 0) {
-				acpid_log("ERR: can't accept client: %s\n", 
-					strerror(errno));
-				continue;
-			}
-			snprintf(buf, sizeof(buf)-1, "%d[%d:%d]",
-				creds.pid, creds.uid, creds.gid);
-			acpid_add_client(cli_fd, buf);
-		}
+                /* wait until somebody has some input for us */
+                testfds = readfds;
+                r = select(max_fd_num + 1, &testfds, NULL, NULL, NULL);
+
+                /* check for error conditions */
+                if (r < 0)
+                  switch (errno) {
+                  case EINVAL:
+                  case EBADF:
+                    /* we shouldn't be here */
+		    acpid_log("unrecoverable internal error with select()\n");
+                    clean_exit(errno);
+                    break;
+                  case EINTR:
+                  default:
+                    /* just go back to waiting */
+                    continue;
+                    break;
+                  }
+
+                /* handle the fds that have input */
+                while (r > 0) {
+                  /* see if the fd is set */
+                  if (FD_ISSET(fds, &testfds)) {
+                    /* one less to handle */
+                    r--;
+
+                    if (fds == event_fd) { 
+                      /* read an acpi event */
+		      char *event;
+
+                      event = read_line(event_fd);
+		      if (event) {
+                        acpid_log("received event \"%s\"\n", event);
+                        acpid_handle_event(event);
+                        acpid_log("completed event \"%s\"\n", event);
+                      } else {
+                        static int nerrs;
+                        if (++nerrs >= ACPI_MAX_ERRS) {
+                          acpid_log("too many errors reading "
+                                    "events file - aborting\n");
+                          break;
+                        }
+                      }
+		    }
+                    if (fds == sock_fd) {
+                      /* a client is trying to connect */ 
+		      int cli_fd;
+		      struct ucred creds;
+		      char buf[32];
+
+                      cli_fd = ud_accept(sock_fd, &creds);
+                      if (cli_fd < 0) {
+                        acpid_log("ERR: can't accept client: %s\n", 
+                                  strerror(errno));
+                        continue;
+                      }
+                      snprintf(buf, sizeof(buf)-1, "%d[%d:%d]",
+                               creds.pid, creds.uid, creds.gid);
+                      acpid_add_client(cli_fd, buf);
+                    }
+		  }
+                  
+                  /* next */
+                  fds++;
+                }
 	}
 	
 	clean_exit(EXIT_SUCCESS);
@@ -450,43 +425,27 @@
  * This depends on fixes in linux ACPI after 2.4.8
  */
 #define MAX_BUFLEN	1024
+
 static char *
 read_line(int fd)
 {
-	static char *buf;
-	int buflen = 64;
-	int i = 0;
-	int r;
-	int searching = 1;
-
-	while (searching) {
-		buf = realloc(buf, buflen);
-		if (!buf) {
-			acpid_log("ERR: malloc(%d): %s\n", 
-				buflen, strerror(errno));
-			return NULL;
-		}
-		memset(buf+i, 0, buflen-i);
+	static char buf[MAX_BUFLEN] = "";
+	int r = 0;
 
-		while (i < buflen) {
-			r = read(fd, buf+i, 1);
-			if (r < 0 && errno != EINTR) {
-				/* we should do something with the data */
-				return NULL;
-			} else if (r == 1) {
-				if (buf[i] == '\n') {
-					searching = 0;
-					buf[i] = '\0';
-					break;
-				}
-				i++;
-			}
-		}
-		if (buflen >= MAX_BUFLEN) {
-			break;
-		} 
-		buflen *= 2;
-	}
+	/* get a buffer full of data */
+	while (r == 0)
+	  {
+	    r = read(fd, buf, MAX_BUFLEN - 1);
+	    
+	    if (r == 0)
+	      continue;
+	    else if (r < 0)
+	      return NULL;
+	  }
+
+	/* strip eol */
+	if (buf[r - 1] == '\n')
+	  buf[r - 1] = '\0';
 
 	return buf;
 }

--=-AUWOXfwxwJedjV7baRG4
Content-Disposition: attachment; filename=acpid-1.0.4.diff
Content-Type: text/x-patch; name=acpid-1.0.4.diff; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

--- acpid-1.0.3.orig/acpid-1.0.3.spec	1970-01-01 01:00:00.000000000 +0100
+++ acpid-1.0.3/acpid-1.0.3.spec	2004-05-30 06:49:38.000000000 +0100
@@ -0,0 +1,134 @@
+Summary: ACPI Event Daemon
+Name: acpid
+Version: 1.0.3
+Release: 1
+Copyright: GPL
+Group: System Environment/Daemons
+Source: http://prdownloads.sourceforge.net/acpid/acpid-%{version}.tar.gz
+BuildRoot: %{_tmppath}/%{name}-%{version}-root
+ExclusiveArch: ia64 x86_64 i386
+URL: http://acpid.sourceforge.net/
+Prereq: /sbin/chkconfig, /sbin/service
+
+%description
+acpid is a daemon that dispatches ACPI events to user-space programs.
+  (bug reports to sunthockin-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org)
+
+
+%prep
+%setup
+
+
+%build
+make
+
+
+%install
+rm -rf $RPM_BUILD_ROOT
+mkdir -p $RPM_BUILD_ROOT
+make install INSTPREFIX=3D$RPM_BUILD_ROOT
+
+mkdir -p $RPM_BUILD_ROOT/etc/acpi/events
+mkdir -p $RPM_BUILD_ROOT/etc/acpi/actions
+chmod 755 $RPM_BUILD_ROOT/etc/acpi/events
+install -m 644 samples/sample.conf $RPM_BUILD_ROOT/etc/acpi/events
+
+mkdir -p $RPM_BUILD_ROOT/var/log
+touch $RPM_BUILD_ROOT/var/log/acpid
+chmod 640 $RPM_BUILD_ROOT/var/log/acpid
+
+mkdir -p $RPM_BUILD_ROOT/etc/rc.d/init.d
+install -m 755 redhat/acpid.init $RPM_BUILD_ROOT/etc/rc.d/init.d/acpid
+chmod 755 $RPM_BUILD_ROOT/etc/rc.d/init.d/acpid
+
+
+%clean
+rm -rf $RPM_BUILD_ROOT
+
+
+%files
+%defattr(-,root,root)
+%dir /etc/acpi
+%dir /etc/acpi/events
+%dir /etc/acpi/actions
+%config %attr(0644,root,root) /etc/acpi/events/sample.conf
+/var/log/acpid
+/usr/sbin/acpid
+/usr/bin/acpi_listen
+%attr(0755,root,root) /etc/rc.d/init.d/acpid
+/usr/share/man/man8/acpid.8.gz
+/usr/share/man/man8/acpi_listen.8.gz
+
+
+%post
+/sbin/chkconfig --add acpid
+
+
+%preun
+# only run if this is the last instance to be removed
+if [ "$1" =3D "0" ]; then
+	service acpid stop >/dev/null 2>&1
+	/sbin/chkconfig --del acpid
+fi
+
+%changelog
+* Sun May 30 2004  S=E9rgio Basto <sergiomb-iA+eEnwkJgzk1uMJSBkQmQ@public.gmane.org>
+  - with acpid-1.0.2-5.src.rpm from Fedora Core 1, rebuild redhat dir
+  - put 'make rpm' again=20
+
+* Fri Feb 13 2004  Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
+  - dump debian/ and redhat/ dirs -- too much hassle
+  - change 'make rpm' to 'make dist'
+  - minor Makefile cleanup
+  - README cleanup
+  - prep for 1.0.3 release
+
+* Thu Dec 18 2003  Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
+  - unblock signals before exec()ing a handler
+  - remove odd 'been_here' from signals_handled() (debug artifact?)
+
+* Mon Nov 24 2003  Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
+  - add -c, --count option to acpi_listen (Luca Capello <luca.pca.it>)
+  - add -t, --time option to acpi_listen (Luca Capello <luca.pca.it>)
+  - return a meaningful value if we break out of the main loop (acpi_liste=
n.c)
+  - break out usage() from handle_cmdline() (acpi_listen.c)
+
+* Mon Nov 17 2003  Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
+  - Decouple logging to stdout from foregrounding
+  - Add acpi_listen (source and man)
+  - Add ud_connect()
+  - Remove (euid =3D=3D 0) check
+  - ifdef the bad-kernel checking - it consumes a byte of data!
+
+* Fri Nov 14 2003  Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
+  - Add -f option (run in foreground)
+
+* Tue May 13 2003  Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
+  - Fixed a dumb bug with %e expansion for commands
+  - Add COPYING file
+  - Add TODO file
+
+* Fri Mar 15 2002  Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
+  - Updated RPM spec with patch from sun for chkconfig on/off
+  - Add Changelog, make 'make rpm' use it.
+  - 1.0.1
+
+* Wed Mar 13 2002  Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
+  - Fixed logging bug - not appending to log (O_APPEND needed)
+  - Fix 'make install' to not need root access
+  - Fix RPM spec to not need root
+
+* Thu Sep 6 2001 Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
+  - 1.0.0
+
+* Thu Aug 16 2001  Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
+  - Added commandline options to actions
+
+* Wed Aug 15 2001  Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
+  - Added UNIX domain socket support
+  - Changed /etc/acpid.d to /etc/acpid/events
+
+* Mon Aug 13 2001  Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
+  - added changelog
+  - 0.99.1-1
+
--- acpid-1.0.3.orig/Changelog	2004-02-13 19:05:34.000000000 +0000
+++ acpid-1.0.3/Changelog	2004-05-30 06:45:25.000000000 +0100
@@ -1,4 +1,8 @@
 %changelog
+* Sun May 30 2004  S=E9rgio Basto <sergiomb-iA+eEnwkJgzk1uMJSBkQmQ@public.gmane.org>
+  - with acpid-1.0.2-5.src.rpm from Fedora Core 1, rebuild redhat dir
+  - put 'make rpm' again=20
+
 * Fri Feb 13 2004  Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
   - dump debian/ and redhat/ dirs -- too much hassle
   - change 'make rpm' to 'make dist'
--- acpid-1.0.3.orig/Makefile	2004-02-24 23:52:37.000000000 +0000
+++ acpid-1.0.3/Makefile	2004-05-30 06:49:35.000000000 +0100
@@ -2,6 +2,7 @@
=20
 # update these numbers for new releases
 VERSION =3D 1.0.3
+RELEASE =3D 1
=20
 INSTPREFIX =3D
 BINDIR =3D $(INSTPREFIX)/usr/bin
@@ -36,6 +37,7 @@
 install: $(PROGS) man
 	mkdir -p $(SBINDIR)
 	install -m 750 acpid $(SBINDIR)
+	mkdir -p $(BINDIR)
 	install -m 755 acpi_listen $(BINDIR)
 	mkdir -p $(MAN8DIR)
 	install -m 644 $(MAN8GZ) $(MAN8DIR)
@@ -50,6 +52,22 @@
 	tar -C $(DISTTMP) -zcvf acpid-$(VERSION).tar.gz acpid-$(VERSION)
 	rm -rf $(DISTTMP)/acpid-$(VERSION)
=20
+RPMTMP=3D/tmp
+rpm:=20
+	make clean=20
+	rm -rf $(RPMTMP)/acpid-$(VERSION)
+	mkdir -p $(RPMTMP)/acpid-$(VERSION)
+	sed -e 's/@@RPMVER@@/$(VERSION)/' -e 's/@@RPMREL@@/$(RELEASE)/' \
+		redhat/acpid.spec.in > acpid-$(VERSION).spec
+	cat Changelog >> acpid-$(VERSION).spec
+	cp -a * $(RPMTMP)/acpid-$(VERSION)
+	find $(RPMTMP)/acpid-$(VERSION) -type d -name CVS | xargs rm -rf
+	tar -C $(RPMTMP) -zcvf $(RPMTMP)/acpid-$(VERSION).tar.gz \
+        acpid-$(VERSION)
+	rpmbuild -ta $(RPMTMP)/acpid-$(VERSION).tar.gz
+	rm -rf $(RPMTMP)/acpid-$(VERSION)
+	rm -rf $(RPMTMP)/acpid-$(VERSION).tar.gz
+
 clean:
 	$(RM) $(PROGS) $(MAN8GZ) *.o
=20
--- acpid-1.0.3.orig/redhat/acpid.init	1970-01-01 01:00:00.000000000 +0100
+++ acpid-1.0.3/redhat/acpid.init	2004-05-30 06:16:51.000000000 +0100
@@ -0,0 +1,83 @@
+#!/bin/bash
+#
+#	/etc/rc.d/init.d/acpid
+#
+# Starts the acpi daemon
+#
+# chkconfig: 345 44 56
+# description: Listen and dispatch ACPI events from the kernel
+# processname: acpid
+
+# Source function library.
+. /etc/rc.d/init.d/functions
+
+DAEMON=3Dacpi
+PROGNAME=3D${DAEMON}d
+test -x /usr/sbin/$PROGNAME || exit 0
+
+RETVAL=3D0
+
+#
+# See how we were called.
+#
+
+start() {
+	# Check if it is already running
+	if [ ! -f /var/lock/subsys/$PROGNAME ]; then
+	    echo -n "Starting $DAEMON daemon: "
+	    daemon /usr/sbin/$PROGNAME
+	    RETVAL=3D$?
+	    [ $RETVAL -eq 0 ] && touch /var/lock/subsys/$PROGNAME
+	    echo
+	fi
+	return $RETVAL
+}
+
+stop() {
+	echo -n "Stopping $DAEMON daemon: "
+	killproc /usr/sbin/$PROGNAME
+	RETVAL=3D$?
+	[ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/$PROGNAME
+	echo
+        return $RETVAL
+}
+
+
+restart() {
+	stop
+	start
+}=09
+
+reload() {
+	trap "" SIGHUP
+	killall -HUP $PROGNAME
+}=09
+
+case "$1" in
+start)
+	start
+	;;
+stop)
+	stop
+	;;
+reload)
+	reload
+	;;
+restart)
+	restart
+	;;
+condrestart)
+	if [ -f /var/lock/subsys/$PROGNAME ]; then
+	    restart
+	fi
+	;;
+status)
+	status $PROGNAME
+	;;
+*)
+	INITNAME=3D`basename $0`
+	echo "Usage: $INITNAME {start|stop|restart|condrestart|status}"
+	exit 1
+esac
+
+exit $RETVAL
--- acpid-1.0.3.orig/redhat/acpid.spec.in	1970-01-01 01:00:00.000000000 +01=
00
+++ acpid-1.0.3/redhat/acpid.spec.in	2004-05-30 06:39:05.000000000 +0100
@@ -0,0 +1,73 @@
+Summary: ACPI Event Daemon
+Name: acpid
+Version: @@RPMVER@@
+Release: @@RPMREL@@
+Copyright: GPL
+Group: System Environment/Daemons
+Source: http://prdownloads.sourceforge.net/acpid/acpid-%{version}.tar.gz
+BuildRoot: %{_tmppath}/%{name}-%{version}-root
+ExclusiveArch: ia64 x86_64 i386
+URL: http://acpid.sourceforge.net/
+Prereq: /sbin/chkconfig, /sbin/service
+
+%description
+acpid is a daemon that dispatches ACPI events to user-space programs.
+  (bug reports to sunthockin-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org)
+
+
+%prep
+%setup
+
+
+%build
+make
+
+
+%install
+rm -rf $RPM_BUILD_ROOT
+mkdir -p $RPM_BUILD_ROOT
+make install INSTPREFIX=3D$RPM_BUILD_ROOT
+
+mkdir -p $RPM_BUILD_ROOT/etc/acpi/events
+mkdir -p $RPM_BUILD_ROOT/etc/acpi/actions
+chmod 755 $RPM_BUILD_ROOT/etc/acpi/events
+install -m 644 samples/sample.conf $RPM_BUILD_ROOT/etc/acpi/events
+
+mkdir -p $RPM_BUILD_ROOT/var/log
+touch $RPM_BUILD_ROOT/var/log/acpid
+chmod 640 $RPM_BUILD_ROOT/var/log/acpid
+
+mkdir -p $RPM_BUILD_ROOT/etc/rc.d/init.d
+install -m 755 redhat/acpid.init $RPM_BUILD_ROOT/etc/rc.d/init.d/acpid
+chmod 755 $RPM_BUILD_ROOT/etc/rc.d/init.d/acpid
+
+
+%clean
+rm -rf $RPM_BUILD_ROOT
+
+
+%files
+%defattr(-,root,root)
+%dir /etc/acpi
+%dir /etc/acpi/events
+%dir /etc/acpi/actions
+%config %attr(0644,root,root) /etc/acpi/events/sample.conf
+/var/log/acpid
+/usr/sbin/acpid
+/usr/bin/acpi_listen
+%attr(0755,root,root) /etc/rc.d/init.d/acpid
+/usr/share/man/man8/acpid.8.gz
+/usr/share/man/man8/acpi_listen.8.gz
+
+
+%post
+/sbin/chkconfig --add acpid
+
+
+%preun
+# only run if this is the last instance to be removed
+if [ "$1" =3D "0" ]; then
+	service acpid stop >/dev/null 2>&1
+	/sbin/chkconfig --del acpid
+fi
+
--- acpid-1.0.3.orig/samples/sample.conf	2001-08-16 22:50:27.000000000 +010=
0
+++ acpid-1.0.3/samples/sample.conf	2004-05-30 05:37:06.000000000 +0100
@@ -1,4 +1,4 @@
 # This is a sample ACPID configuration
=20
-# event=3Dbutton power.*
-# action=3D/usr/local/bin/power.sh "%e"
+event=3Dbutton/power.*
+action=3D/sbin/shutdown -h now

--=-AUWOXfwxwJedjV7baRG4--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
